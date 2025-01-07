module 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu {
    struct FuMintedEvent has copy, drop {
        fu_id: 0x2::object::ID,
        nft_id: u64,
        name: 0x1::string::String,
        font: u8,
        minter: address,
    }

    struct FU has drop {
        dummy_field: bool,
    }

    struct FuCharacter has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        font: u8,
        strokes: 0x2::object_table::ObjectTable<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>,
        synthesized: bool,
        required_strokes: u8,
    }

    struct FuMinter has key {
        id: 0x2::object::UID,
        counter: u64,
        version: u64,
    }

    struct FuFontConfig has key {
        id: 0x2::object::UID,
        max_fonts: u8,
        required_strokes_map: 0x2::table::Table<u8, u8>,
        version: u64,
    }

    public entry fun add_stroke(arg0: &mut FuCharacter, arg1: 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke) {
        assert!(!is_complete(arg0), 2);
        assert!(arg0.font == 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::font(&arg1), 0);
        let v0 = 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::stroke_type(&arg1);
        assert!(!0x2::object_table::contains<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&arg0.strokes, v0), 1);
        0x2::object_table::add<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&mut arg0.strokes, v0, arg1);
    }

    public fun font(arg0: &FuCharacter) : u8 {
        arg0.font
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://fuzion-sui.vercel.app/my-collection/fu/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://fuzion-sui.vercel.app/fu-characters/{id}/svg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A customizable Fu character NFT with different fonts"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://fuzion-sui.vercel.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Fu Character Team"));
        let v4 = 0x2::package::claim<FU>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<FuCharacter>(&v4, v0, v2, arg1);
        0x2::display::update_version<FuCharacter>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FuCharacter>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = FuMinter{
            id      : 0x2::object::new(arg1),
            counter : 0,
            version : 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version(),
        };
        0x2::transfer::share_object<FuMinter>(v6);
        let v7 = FuFontConfig{
            id                   : 0x2::object::new(arg1),
            max_fonts            : 6,
            required_strokes_map : 0x2::table::new<u8, u8>(arg1),
            version              : 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version(),
        };
        0x2::table::add<u8, u8>(&mut v7.required_strokes_map, 1, 5);
        0x2::table::add<u8, u8>(&mut v7.required_strokes_map, 2, 6);
        0x2::table::add<u8, u8>(&mut v7.required_strokes_map, 3, 7);
        0x2::table::add<u8, u8>(&mut v7.required_strokes_map, 4, 5);
        0x2::table::add<u8, u8>(&mut v7.required_strokes_map, 5, 5);
        0x2::table::add<u8, u8>(&mut v7.required_strokes_map, 6, 7);
        0x2::transfer::share_object<FuFontConfig>(v7);
    }

    public fun is_complete(arg0: &FuCharacter) : bool {
        0x2::object_table::length<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&arg0.strokes) == (arg0.required_strokes as u64)
    }

    public fun max_fonts(arg0: &FuFontConfig) : u8 {
        arg0.max_fonts
    }

    public(friend) fun migrate(arg0: &mut FuMinter, arg1: &mut FuFontConfig) {
        arg0.version = 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version();
        arg1.version = 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version();
    }

    entry fun mint_to_sender(arg0: &mut FuMinter, arg1: &FuFontConfig, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg0.version);
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg1.version);
        arg0.counter = arg0.counter + 1;
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, arg1.max_fonts);
        let v2 = arg0.counter;
        let v3 = 0x1::string::utf8(b"Fu Character");
        let v4 = FuCharacter{
            id               : 0x2::object::new(arg3),
            nft_id           : v2,
            name             : v3,
            font             : v1,
            strokes          : 0x2::object_table::new<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(arg3),
            synthesized      : false,
            required_strokes : *0x2::table::borrow<u8, u8>(&arg1.required_strokes_map, v1),
        };
        let v5 = FuMintedEvent{
            fu_id  : 0x2::object::uid_to_inner(&v4.id),
            nft_id : v2,
            name   : v3,
            font   : v1,
            minter : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FuMintedEvent>(v5);
        0x2::transfer::transfer<FuCharacter>(v4, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &FuCharacter) : &0x1::string::String {
        &arg0.name
    }

    public entry fun remove_stroke(arg0: &mut FuCharacter, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_complete(arg0), 2);
        assert!(0x2::object_table::contains<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&arg0.strokes, arg1), 1);
        0x2::transfer::public_transfer<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(0x2::object_table::remove<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&mut arg0.strokes, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun required_strokes(arg0: &FuFontConfig, arg1: u8) : u8 {
        *0x2::table::borrow<u8, u8>(&arg0.required_strokes_map, arg1)
    }

    public fun stroke_count(arg0: &FuCharacter) : u64 {
        0x2::object_table::length<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&arg0.strokes)
    }

    public entry fun synthesize(arg0: &mut FuCharacter) {
        assert!(is_complete(arg0), 3);
        let v0 = 1;
        while (v0 <= arg0.required_strokes) {
            0x2::transfer::public_transfer<0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(0x2::object_table::remove<u8, 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke::Stroke>(&mut arg0.strokes, v0), 0x2::object::uid_to_address(&arg0.id));
            v0 = v0 + 1;
        };
        arg0.synthesized = true;
    }

    // decompiled from Move bytecode v6
}

