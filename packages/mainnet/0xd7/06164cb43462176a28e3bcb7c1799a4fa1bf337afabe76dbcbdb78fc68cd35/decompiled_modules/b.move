module 0xd706164cb43462176a28e3bcb7c1799a4fa1bf337afabe76dbcbdb78fc68cd35::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 9, b"B", b"Bill", b"Meme bill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ff0eea9-1d5e-4cf4-8b87-bed824305707.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B>>(v1);
    }

    // decompiled from Move bytecode v6
}

