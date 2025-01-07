module 0x9d00b640ecb9e5d3a77aef286124eb1b7266c7e7f9dd9781424686cb3356e7ff::felix {
    struct FELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELIX>(arg0, 6, b"FELIX", b"Felix the Cat", b"Hey, I'm Felix, the cat with the bow tie and a talent for getting into (and out of) trouble. I'm always one paw ahead, living life full of adventure, excitement, and a little mischief. It's not easy being this slick.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734537335377.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FELIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

