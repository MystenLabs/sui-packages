module 0x73b5059c6864729b84cf5d7835f53c237b0a4603756780bb920e7539844b466::example {
    struct ColorObject has store, key {
        id: 0x2::object::UID,
        red: u8,
        green: u8,
        blue: u8,
    }

    public fun delete(arg0: ColorObject) {
        let ColorObject {
            id    : v0,
            red   : _,
            green : _,
            blue  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : ColorObject {
        ColorObject{
            id    : 0x2::object::new(arg3),
            red   : arg0,
            green : arg1,
            blue  : arg2,
        }
    }

    public fun copy_into(arg0: &ColorObject, arg1: &mut ColorObject) {
        arg1.red = arg0.red;
        arg1.green = arg0.green;
        arg1.blue = arg0.blue;
    }

    public fun get_color(arg0: &ColorObject) : (u8, u8, u8) {
        (arg0.red, arg0.green, arg0.blue)
    }

    public fun update(arg0: &mut ColorObject, arg1: u8, arg2: u8, arg3: u8) {
        arg0.red = arg1;
        arg0.green = arg2;
        arg0.blue = arg3;
    }

    // decompiled from Move bytecode v6
}

