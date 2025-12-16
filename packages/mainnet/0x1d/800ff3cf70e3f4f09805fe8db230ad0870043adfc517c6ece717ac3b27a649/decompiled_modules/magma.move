module 0x1d800ff3cf70e3f4f09805fe8db230ad0870043adfc517c6ece717ac3b27a649::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 9, b"MAGMA", b"Magma Token", b"MAGMA is the native token of Magma Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yellow-fascinating-hornet-971.mypinata.cloud/ipfs/bafkreihzqruw2jhz4sihh2oorwyq44cragyhngrxvprdespoguyu7vejbi")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGMA>>(0x2::coin::mint<MAGMA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAGMA>>(v2);
    }

    // decompiled from Move bytecode v6
}

