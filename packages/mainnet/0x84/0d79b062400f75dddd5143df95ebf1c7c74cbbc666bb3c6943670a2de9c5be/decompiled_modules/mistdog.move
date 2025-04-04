module 0x840d79b062400f75dddd5143df95ebf1c7c74cbbc666bb3c6943670a2de9c5be::mistdog {
    struct MISTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTDOG>(arg0, 6, b"MISTDOG", b"MISTDOG", b"MISTDOG is the king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MISTDOG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTDOG>>(v2, @0xbfd7dfd219f143e444cd9949cd85d3b4989e5d1ec9956427f5520f2bb86bfd10);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

