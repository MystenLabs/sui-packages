module 0x5e33c06eecf0e3a185e36db3d60f97be53e6c47982ed3bb329fd643a9d34d5ee::ayb {
    struct AYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYB>(arg0, 9, b"AYB", b"Ayoubs Token", b"This is the first every memecoin on memedexx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.recrd.com/discover?post_id=be380b10-1fbc-11ed-b489-77b75cbb0ebe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AYB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYB>>(v2, @0xcd77bc1e00ce9b6eb15bbd89d7e4521330c5fa8a170da7d12081a1d0b003a95);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

