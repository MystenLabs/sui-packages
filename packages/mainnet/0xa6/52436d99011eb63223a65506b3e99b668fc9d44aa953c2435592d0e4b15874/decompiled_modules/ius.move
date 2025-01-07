module 0xa652436d99011eb63223a65506b3e99b668fc9d44aa953c2435592d0e4b15874::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"IUS CTO", x"49207361772074686973207469636b657220676f742072756720627920612064756d626173732e20200a0a4c6574732063726561746520736f6d65206d656d6520616e64207075736820697420746f6765746865722e0a0a456d6f6a69207061636b203a202068747470733a2f2f742e6d652f616464656d6f6a692f6975736e6577656d6f6a690a0a537469636b657273207365743a2068747470733a2f2f742e6d652f616464737469636b6572732f6975736e6577737469636b6572737061636b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IUS_4d0789326d.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

