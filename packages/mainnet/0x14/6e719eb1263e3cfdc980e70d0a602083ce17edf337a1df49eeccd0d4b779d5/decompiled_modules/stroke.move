module 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::stroke {
    struct Stroke has store, key {
        id: 0x2::object::UID,
        stroke_type: u8,
        font: u8,
    }

    struct STROKE has drop {
        dummy_field: bool,
    }

    public(friend) fun create(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Stroke {
        Stroke{
            id          : 0x2::object::new(arg2),
            stroke_type : arg1,
            font        : arg0,
        }
    }

    public fun font(arg0: &Stroke) : u8 {
        arg0.font
    }

    fun init(arg0: STROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Fu Stroke #{stroke_type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A unique stroke from the Fu collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://fuzion-sui.vercel.app/fu-strokes/{font}/{stroke_type}/svg"));
        let v4 = 0x2::package::claim<STROKE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Stroke>(&v4, v0, v2, arg1);
        0x2::display::update_version<Stroke>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Stroke>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun stroke_type(arg0: &Stroke) : u8 {
        arg0.stroke_type
    }

    // decompiled from Move bytecode v6
}

