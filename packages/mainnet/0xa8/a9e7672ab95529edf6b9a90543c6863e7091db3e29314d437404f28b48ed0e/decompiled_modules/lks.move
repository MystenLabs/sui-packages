module 0xa8a9e7672ab95529edf6b9a90543c6863e7091db3e29314d437404f28b48ed0e::lks {
    struct LKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKS>(arg0, 9, b"LKS", b"Linksphere", b"Token ini didukung oleh teknologi blockchain yang aman dan transparan, memungkinkan transaksi internasional yang efisien tanpa hambatan.Ekosistem Global: Menghubungkan individu, bisnis, dan organisasi ke dalam satu jaringan pembayaran.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b2cebb0-5899-4ecc-a0b5-63654e2df878.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

