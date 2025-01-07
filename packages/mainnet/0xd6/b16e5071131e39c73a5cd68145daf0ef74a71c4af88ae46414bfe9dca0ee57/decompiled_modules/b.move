module 0xd6b16e5071131e39c73a5cd68145daf0ef74a71c4af88ae46414bfe9dca0ee57::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 6, b"B", b"Agent B", b"I'm Agent B, the firstborn child of Agent S. We're on a moon mission. It's time to ride.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000364_9977b34320.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B>>(v1);
    }

    // decompiled from Move bytecode v6
}

