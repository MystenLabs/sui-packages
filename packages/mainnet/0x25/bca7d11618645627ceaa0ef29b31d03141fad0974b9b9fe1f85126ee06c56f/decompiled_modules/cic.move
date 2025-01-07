module 0x25bca7d11618645627ceaa0ef29b31d03141fad0974b9b9fe1f85126ee06c56f::cic {
    struct CIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIC>(arg0, 9, b"CIC", b"GIA", b"The world is for digital currency So invest wisely Together! Because \"GIA\" will be a part of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbaa32d4-a3b2-49ed-a492-62346427f5ad-1000504028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

