module 0x71ef5be41ab20d5c8aac7feb78a9bc2e97920ec482a0dc4e7624f9284173445e::puma {
    struct PUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMA>(arg0, 6, b"PUMA", b"SUIPUMA", b"THE PURPOSE OF SUIPUMA IS TO SAVE THE ENDSING PUMAS AND WILD ANIMALS. WE WILL USE A CERTAIN PART OF OUR PROFIT FOR THESE ANIMALS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197804_d90ff8eef2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

