module 0x3d1cae04d49dd36aecbc181032d205640cbab37cc3563a1e2bb0886627bc8279::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct Pixel has store {
        color: u32,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        metadata: 0x2::url::Url,
        x: u64,
        y: u64,
        canvas_periode: u64,
        pixels: vector<Pixel>,
        painted_amount: u64,
        start_time: u64,
        finish_time: u64,
    }

    public entry fun create_game<T0>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u32, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg7) == 1000, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, @0x0);
        let v0 = Game{
            id             : 0x2::object::new(arg8),
            name           : arg0,
            metadata       : 0x2::url::new_unsafe_from_bytes(arg1),
            x              : arg2,
            y              : arg3,
            canvas_periode : arg6,
            pixels         : solid_canvas(arg2, arg3, arg4),
            painted_amount : 0,
            start_time     : arg5,
            finish_time    : arg5 + arg6 * 60 * 1000,
        };
        0x2::transfer::public_transfer<Game>(v0, 0x2::tx_context::sender(arg8));
    }

    fun create_pixel(arg0: u32) : Pixel {
        Pixel{color: arg0}
    }

    public entry fun get_info(arg0: &mut Game) : (0x1::string::String, 0x2::url::Url, u64, u64, u64, u64) {
        (arg0.name, arg0.metadata, arg0.canvas_periode, arg0.painted_amount, arg0.start_time, arg0.finish_time)
    }

    public entry fun get_pixel(arg0: u64, arg1: u64, arg2: &mut Game) : u32 {
        0x1::vector::borrow_mut<Pixel>(&mut arg2.pixels, arg0 + arg1 * arg2.x).color
    }

    public entry fun get_pixels(arg0: u64, arg1: u64, arg2: &mut Game) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 != arg0) {
            let v2 = 0;
            while (v2 != arg1) {
                0x1::vector::push_back<u32>(&mut v0, 0x1::vector::borrow_mut<Pixel>(&mut arg2.pixels, v2 + v1 * arg2.x).color);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://dev-gallery-back.onrender.com/space/image?address={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is a Sui Space Game NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gallery/"));
        let v4 = 0x2::package::claim<GAME>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Game>(&v4, v0, v2, arg1);
        0x2::display::update_version<Game>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Game>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_pixel(arg0: u64, arg1: u32, arg2: &0x2::clock::Clock, arg3: &mut Game) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg3.start_time, 3);
        assert!(!(v0 > arg3.finish_time), 1);
        0x1::vector::borrow_mut<Pixel>(&mut arg3.pixels, arg0).color = arg1;
        arg3.painted_amount = arg3.painted_amount + 1;
    }

    fun solid_canvas(arg0: u64, arg1: u64, arg2: u32) : vector<Pixel> {
        let v0 = 0x1::vector::empty<Pixel>();
        let v1 = 0;
        while (v1 != arg0 * arg1) {
            0x1::vector::push_back<Pixel>(&mut v0, create_pixel(arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun update_finish_time(arg0: u64, arg1: &mut Game) {
        arg1.finish_time = arg0;
    }

    public entry fun update_metadata_url(arg0: vector<u8>, arg1: &mut Game) {
        arg1.metadata = 0x2::url::new_unsafe_from_bytes(arg0);
    }

    public entry fun update_start_time(arg0: u64, arg1: &mut Game) {
        arg1.start_time = arg0;
    }

    // decompiled from Move bytecode v6
}

