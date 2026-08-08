module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft_display {
    struct SFT_DISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFT_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SFT_DISPLAY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun new_stack_display<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>> {
        let v0 = 0x2::display::new<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>>(arg0, arg3);
        0x2::display::add<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>>(&mut v0, 0x1::string::utf8(b"description"), arg1);
        0x2::display::add<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>>(&mut v0, 0x1::string::utf8(b"project_url"), arg2);
        0x2::display::update_version<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft::Stack<T0>>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v7
}

