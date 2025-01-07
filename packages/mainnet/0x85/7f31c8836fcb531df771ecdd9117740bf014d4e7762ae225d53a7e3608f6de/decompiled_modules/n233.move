module 0x857f31c8836fcb531df771ecdd9117740bf014d4e7762ae225d53a7e3608f6de::n233 {
    struct N233 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N233, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N233>(arg0, 9, b"N233", b"GuGu", b"Devil fruit has the ability to help the eater fly 1m above the ground.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d568785-fc5b-4934-a01b-6dde8f8a17f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N233>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N233>>(v1);
    }

    // decompiled from Move bytecode v6
}

