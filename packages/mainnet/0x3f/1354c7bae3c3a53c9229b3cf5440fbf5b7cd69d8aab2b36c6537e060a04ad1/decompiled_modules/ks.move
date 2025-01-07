module 0x3f1354c7bae3c3a53c9229b3cf5440fbf5b7cd69d8aab2b36c6537e060a04ad1::ks {
    struct KS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KS>(arg0, 6, b"KS", b"Kakashi-Sui", b"Kakashi on SUI is an epic tale of a doggo wif hair who can see into the future. Be a degen and follow  Kakashi-Sui to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000780_78c46ff06d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KS>>(v1);
    }

    // decompiled from Move bytecode v6
}

