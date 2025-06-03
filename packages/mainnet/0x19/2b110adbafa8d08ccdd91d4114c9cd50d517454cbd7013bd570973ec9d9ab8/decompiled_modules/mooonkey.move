module 0x192b110adbafa8d08ccdd91d4114c9cd50d517454cbd7013bd570973ec9d9ab8::mooonkey {
    struct MOOONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOONKEY>(arg0, 6, b"MOOONKEY", b"MOONKEY", b"moonkey's journey to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifiax4fq6ihmfyhvqzkieny7gkyxag7ddkwxikjh7erczhpfkos6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOOONKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

