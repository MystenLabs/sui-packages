module 0xf91f0a90e02b936aca16f368f6f1ba89972f40f43992326b6b8e11632a61a310::flatland {
    struct Color has drop, store {
        r: u8,
        g: u8,
        b: u8,
    }

    struct Flatlander has store, key {
        id: 0x2::object::UID,
        color: Color,
        sides: u8,
        hexaddr: 0x1::string::String,
        image_blob: 0x1::string::String,
    }

    struct FLATLAND has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut 0x2::tx_context::TxContext) : Flatlander {
        let v0 = 0x2::object::new(arg1);
        let v1 = random_color(arg0);
        let v2 = random_sides(arg0);
        Flatlander{
            id         : v0,
            color      : v1,
            sides      : v2,
            hexaddr    : 0x1::string::utf8(0x2::hex::encode(0x2::object::uid_to_bytes(&v0))),
            image_blob : svg(v2, &v1),
        }
    }

    fun init(arg0: FLATLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FLATLAND>(arg0, arg1);
        let v1 = 0x2::display::new<Flatlander>(&v0, arg1);
        0x2::display::add<Flatlander>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://flatland.wal.app/0x{hexaddr}"));
        0x2::display::add<Flatlander>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml;charset=utf8,{image_blob}"));
        0x2::display::update_version<Flatlander>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Flatlander>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = &mut v0;
        let v2 = new(v1, arg1);
        0x2::transfer::transfer<Flatlander>(v2, 0x2::tx_context::sender(arg1));
    }

    fun num_to_ascii(arg0: u64) : vector<u8> {
        let v0 = b"";
        if (arg0 == 0) {
            return b"0"
        };
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::insert<u8>(&mut v0, v1 + 48, 0);
        };
        v0
    }

    fun random_color(arg0: &mut 0x2::random::RandomGenerator) : Color {
        Color{
            r : 0x2::random::generate_u8(arg0),
            g : 0x2::random::generate_u8(arg0),
            b : 0x2::random::generate_u8(arg0),
        }
    }

    fun random_sides(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        0x2::random::generate_u8_in_range(arg0, 3, 14)
    }

    fun svg(arg0: u8, arg1: &Color) : 0x1::string::String {
        let v0 = num_to_ascii((arg1.r as u64));
        let v1 = num_to_ascii((arg1.g as u64));
        let v2 = num_to_ascii((arg1.b as u64));
        let v3 = vector[b"100.0,50.0 143.30127018922195,125.0 56.698729810778076,125.00000000000001", b"100.0,50.0 150.0,100.0 100.0,150.0 50.0,100.0", b"100.0,50.0 147.55282581475768,84.54915028125264 129.38926261462365,140.45084971874738 70.61073738537635,140.45084971874738 52.44717418524232,84.54915028125264", b"100.0,50.0 143.30127018922192,75.0 143.30127018922195,125.0 100.0,150.0 56.698729810778076,125.00000000000001 56.69872981077805,75.00000000000003", b"100.0,50.0 139.0915741234015,68.82550990706332 148.74639560909117,111.12604669781572 121.69418695587791,145.04844339512096 78.30581304412209,145.04844339512096 51.25360439090882,111.12604669781572 60.90842587659851,68.82550990706333", b"100.0,50.0 135.35533905932738,64.64466094067262 150.0,100.0 135.35533905932738,135.35533905932738 100.0,150.0 64.64466094067262,135.35533905932738 50.0,100.0 64.64466094067262,64.64466094067262", b"100.0,50.0 132.13938048432698,61.697777844051096 149.2403876506104,91.31759111665349 143.30127018922195,125.0 117.10100716628344,146.9846310392954 82.89899283371656,146.98463103929544 56.698729810778076,125.00000000000001 50.75961234938959,91.3175911166535 67.86061951567302,61.6977778440511", b"100.0,50.0 129.38926261462365,59.54915028125263 147.55282581475768,84.54915028125264 147.55282581475768,115.45084971874736 129.38926261462365,140.45084971874738 100.0,150.0 70.61073738537635,140.45084971874738 52.447174185242325,115.45084971874738 52.44717418524232,84.54915028125264 70.61073738537634,59.549150281252636", b"100.0,50.0 127.03204087277989,57.93732335844094 145.48159976772592,79.22924934990569 149.49107209404664,107.11574191366425 137.78747871771293,132.74303669726424 114.08662784207148,147.97464868072487 85.91337215792853,147.97464868072487 62.21252128228709,132.74303669726424 50.508927905953364,107.11574191366427 54.518400232274075,79.2292493499057 72.96795912722013,57.93732335844094", b"100.0,50.0 125.0,56.69872981077806 143.30127018922192,75.0 150.0,100.0 143.30127018922195,125.0 125.00000000000001,143.30127018922192 100.0,150.0 75.0,143.30127018922195 56.698729810778076,125.00000000000001 50.0,100.0 56.69872981077805,75.00000000000003 74.99999999999997,56.69872981077808", b"100.0,50.0 123.23615860218842,55.72719871733951 141.14919329468282,71.5967626634422 149.63544370490268,93.97316598723384 146.75081213427075,117.73024435212677 133.15613291203977,137.42553740855504 111.96578321437791,148.5470908713026 88.03421678562212,148.5470908713026 66.84386708796025,137.42553740855507 53.24918786572926,117.73024435212679 50.364556295097294,93.97316598723388 58.850806705317176,71.59676266344222 76.76384139781155,55.72719871733952", b"100.0,50.0 121.69418695587791,54.951556604879045 139.0915741234015,68.82550990706332 148.74639560909117,88.87395330218428 148.74639560909117,111.12604669781572 139.0915741234015,131.17449009293668 121.69418695587791,145.04844339512096 100.0,150.0 78.30581304412209,145.04844339512096 60.908425876598514,131.17449009293668 51.25360439090882,111.12604669781572 51.25360439090882,88.87395330218429 60.90842587659851,68.82550990706333 78.30581304412209,54.951556604879045"];
        let v4 = 0x1::vector::empty<vector<u8>>();
        let v5 = &mut v4;
        0x1::vector::push_back<vector<u8>>(v5, b"<svg width='200' height='200' xmlns='http://www.w3.org/2000/svg'>");
        0x1::vector::push_back<vector<u8>>(v5, b"<rect width='200' height='200' fill = 'rgba(");
        0x1::vector::push_back<vector<u8>>(v5, v0);
        0x1::vector::push_back<vector<u8>>(v5, b",");
        0x1::vector::push_back<vector<u8>>(v5, v1);
        0x1::vector::push_back<vector<u8>>(v5, b",");
        0x1::vector::push_back<vector<u8>>(v5, v2);
        0x1::vector::push_back<vector<u8>>(v5, b",0.2)' />");
        0x1::vector::push_back<vector<u8>>(v5, b"<polygon fill = 'rgba(");
        0x1::vector::push_back<vector<u8>>(v5, v0);
        0x1::vector::push_back<vector<u8>>(v5, b",");
        0x1::vector::push_back<vector<u8>>(v5, v1);
        0x1::vector::push_back<vector<u8>>(v5, b",");
        0x1::vector::push_back<vector<u8>>(v5, v2);
        0x1::vector::push_back<vector<u8>>(v5, b",1)' ");
        0x1::vector::push_back<vector<u8>>(v5, b"points = '");
        0x1::vector::push_back<vector<u8>>(v5, *0x1::vector::borrow<vector<u8>>(&v3, ((arg0 - 3) as u64)));
        0x1::vector::push_back<vector<u8>>(v5, b"'>");
        0x1::vector::push_back<vector<u8>>(v5, b"<animateTransform attributeName='transform' begin='0s' dur='10s' type='rotate' from='0 100 100' to='360 100 100' repeatCount='indefinite'></animateTransform></polygon>");
        0x1::vector::push_back<vector<u8>>(v5, b"</svg>");
        0x1::vector::reverse<vector<u8>>(&mut v4);
        let v6 = b"";
        let v7 = 0;
        while (v7 < 0x1::vector::length<vector<u8>>(&v4)) {
            0x1::vector::append<u8>(&mut v6, 0x1::vector::pop_back<vector<u8>>(&mut v4));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v4);
        0x1::string::utf8(v6)
    }

    // decompiled from Move bytecode v6
}

