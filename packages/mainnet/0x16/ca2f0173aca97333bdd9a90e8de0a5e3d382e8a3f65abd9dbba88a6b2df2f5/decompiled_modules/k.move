module 0x16ca2f0173aca97333bdd9a90e8de0a5e3d382e8a3f65abd9dbba88a6b2df2f5::k {
    struct K has drop {
        dummy_field: bool,
    }

    fun init(arg0: K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K>(arg0, 9, b"K", b"Key", b"ToMoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6a8e5e2-5781-4d28-bf47-0a2c38107575.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K>>(v1);
    }

    // decompiled from Move bytecode v6
}

