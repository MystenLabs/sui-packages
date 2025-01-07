module 0xaa4f3ef09cd73a3da892c88ae46dcd13807a1bafa21bbc5b24148295ff948e9e::sio {
    struct SIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIO>(arg0, 6, b"SIO", b"SUIMBO", b"ONLY FLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_elephant_1_9698649b8e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

