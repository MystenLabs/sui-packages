module 0x565a3d08e54d1fedf9858df4f10513b5a9081ceffb691bccde73a5c8dc78209f::wstdog {
    struct WSTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSTDOG>(arg0, 6, b"WSTDOG", b"WSTDOG", b"This is WSTDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WSTDOG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSTDOG>>(v2, @0xbfd7dfd219f143e444cd9949cd85d3b4989e5d1ec9956427f5520f2bb86bfd10);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

