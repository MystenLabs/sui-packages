module 0x9e7637b8f1887fb4deac10f9ecbaf475341ed670ce9fd230ecf9b5f3d73bc73d::tcf {
    struct TCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCF>(arg0, 6, b"TCF", b"The Chicken Fish", b"I am dangerous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9191_ac1012624c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

