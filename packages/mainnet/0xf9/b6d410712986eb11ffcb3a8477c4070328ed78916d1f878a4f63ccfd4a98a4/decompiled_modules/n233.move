module 0xf9b6d410712986eb11ffcb3a8477c4070328ed78916d1f878a4f63ccfd4a98a4::n233 {
    struct N233 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N233, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N233>(arg0, 9, b"N233", b"GuGu", b"Devil fruit has the ability to help the eater fly 1m above the ground.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec0fa029-0b62-4674-b318-60d53713fc06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N233>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N233>>(v1);
    }

    // decompiled from Move bytecode v6
}

