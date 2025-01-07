module 0x888c1edb1746fece776fe20975914ac96ef572f26f818ace5995c95405dc5d78::lks {
    struct LKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKS>(arg0, 9, b"LKS", b"Linksphere", b"Token ini didukung oleh teknologi blockchain yang aman dan transparan, memungkinkan transaksi internasional yang efisien tanpa hambatan.Ekosistem Global: Menghubungkan individu, bisnis, dan organisasi ke dalam satu jaringan pembayaran.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a947ead-7c24-4b4f-bb3d-3b4cc48ce7ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

