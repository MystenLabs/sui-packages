module 0x3870da790f80546cd3d582b24925cf27937b0f18f890dacc0c956913d4e7411b::avnyx {
    struct AVNYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVNYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVNYX>(arg0, 9, b"AVNYX", b"Baby Dragon Avnyx", b"Avnyx is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/785/527/large/olena-chervoniuk-baby-dragon-jpg.jpg?1728500205")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AVNYX>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVNYX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVNYX>>(v1);
    }

    // decompiled from Move bytecode v6
}

