module 0xed5fe2bd35164a93145a8e0b1e679b8bb03972b7511335647f9f4e059ce11d74::movepump {
    struct MOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPUMP>(arg0, 9, b"MOVEPUMP", b"MovePump2.0", b"The First Meme Fair Launch Platform on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_08_30_15_50_18_225468e896.jpg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOVEPUMP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

