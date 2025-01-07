module 0xc934c6a9635f91e746397bd5c3aa91fbc7af136542c8d2f825a45800acf62642::sbrute {
    struct SBRUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRUTE>(arg0, 6, b"SBRUTE", b"BRUTE", b"Join the fight to the top coins Brute vs Brett", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vau_Cp1_IZ_400x400_7bbe340133.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

