module 0x85b424dd530818c71fff50a458d97d433621462cc6178cf132fb787fe89d0ec0::mushroomsui {
    struct MUSHROOMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHROOMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHROOMSUI>(arg0, 9, b"MSHSUI", b"Mushroomsui", b"A spotted mushroom with tiny legs, cap decorated with Sui symbols, dancing in a magical forest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreicr6s4lzxkfzflbizw2e6z6h4prkknszyrhhnk7ieprashbngmdse")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUSHROOMSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHROOMSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSHROOMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

