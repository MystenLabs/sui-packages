module 0x9cab410b4ea32521367ebad560ffcd4cacaf5bb44a2d35953c96a45290ba221e::chaos {
    struct CHAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOS>(arg0, 9, b"CHAOS", b"Antimatter", b"C H A O S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f706719e3b11911720d7d0652bbd0259blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

