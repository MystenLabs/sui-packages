module 0x32d633c44ebb8e0e54d23e6b694a4bea03bec43444cd56420e405a3c51baa097::neideng {
    struct NEIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIDENG>(arg0, 6, b"NEIDENG", b"Neiro Wif Moo Deng", b"Picture Neiro, the spirited dog, wearing a quirky hat adorned with an image of his best buddy, Moo Deng the hippo. The hat perfectly captures their unique friendshipNeiros playful, energetic vibes meshing with Moo Dengs calm, protective presence. Together, they make a charming duo, ready for any adventure that comes their way. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040569_5e0a19dc75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

