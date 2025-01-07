module 0xd50c19fc48d7b0bb4bc69f0826943392732f90a38786f74305f6d02f0ac0d974::lks {
    struct LKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKS>(arg0, 9, b"LKS", b"Linksphere", b"Token ini didukung oleh teknologi blockchain yang aman dan transparan, memungkinkan transaksi internasional yang efisien tanpa hambatan.Ekosistem Global: Menghubungkan individu, bisnis, dan organisasi ke dalam satu jaringan pembayaran.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19a3c7a1-2fbe-4772-bf4c-40dc02d93f59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

