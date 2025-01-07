module 0x2c0cde3f615a7e30ddf2c0fcb1bfa199b47a5501c8d94b0f260f801aee2610c2::color_object {
    struct ColorObject has key {
        id: 0x2::object::UID,
        red: u8,
        green: u8,
        blue: u8,
    }

    public entry fun delete(arg0: ColorObject) {
        let ColorObject {
            id    : v0,
            red   : _,
            green : _,
            blue  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun new(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : ColorObject {
        ColorObject{
            id    : 0x2::object::new(arg3),
            red   : arg0,
            green : arg1,
            blue  : arg2,
        }
    }

    public entry fun transfer(arg0: ColorObject, arg1: address) {
        0x2::transfer::transfer<ColorObject>(arg0, arg1);
    }

    public entry fun freeze_object(arg0: ColorObject) {
        0x2::transfer::freeze_object<ColorObject>(arg0);
    }

    public entry fun copy_into(arg0: &ColorObject, arg1: &mut ColorObject) {
        arg1.red = arg0.red;
        arg1.green = arg0.green;
        arg1.blue = arg0.blue;
    }

    public entry fun create(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<ColorObject>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_immutable(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::freeze_object<ColorObject>(new(arg0, arg1, arg2, arg3));
    }

    public fun get_color(arg0: &ColorObject) : (u8, u8, u8) {
        (arg0.red, arg0.green, arg0.blue)
    }

    public entry fun update(arg0: &mut ColorObject, arg1: u8, arg2: u8, arg3: u8) {
        arg0.red = arg1;
        arg0.green = arg2;
        arg0.blue = arg3;
    }

    // decompiled from Move bytecode v6
}

