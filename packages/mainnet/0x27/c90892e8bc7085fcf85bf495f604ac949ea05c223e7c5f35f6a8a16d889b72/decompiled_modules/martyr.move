module 0x27c90892e8bc7085fcf85bf495f604ac949ea05c223e7c5f35f6a8a16d889b72::martyr {
    struct MARTYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTYR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARTYR>(arg0, 9, b"martyr", b"Martyr", b"Martyr is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/785/527/large/olena-chervoniuk-baby-dragon-jpg.jpg?1728500205")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARTYR>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARTYR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARTYR>>(v1);
    }

    // decompiled from Move bytecode v6
}

