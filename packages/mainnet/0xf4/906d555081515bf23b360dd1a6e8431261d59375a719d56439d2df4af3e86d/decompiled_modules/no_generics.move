module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::no_generics {
    struct WhiteBox has key {
        id: 0x2::object::UID,
        content: u8,
    }

    struct BlackBox has key {
        id: 0x2::object::UID,
        content: u64,
    }

    struct BlueBox has key {
        id: 0x2::object::UID,
        content: bool,
    }

    struct RedBox has key {
        id: 0x2::object::UID,
        content: address,
    }

    struct GreenBox has key {
        id: 0x2::object::UID,
        content: Secret,
    }

    struct Secret has store {
        value: u64,
    }

    public fun new_black_box(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlackBox{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::transfer<BlackBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_blue_box(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlueBox{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::transfer<BlueBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_green_box(arg0: Secret, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GreenBox{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::transfer<GreenBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_red_box(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RedBox{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::transfer<RedBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_secret(arg0: u64) : Secret {
        Secret{value: arg0}
    }

    public fun new_white_box(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WhiteBox{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::transfer<WhiteBox>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

