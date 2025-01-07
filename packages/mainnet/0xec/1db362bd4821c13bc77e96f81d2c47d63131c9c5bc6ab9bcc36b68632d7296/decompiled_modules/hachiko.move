module 0xec1db362bd4821c13bc77e96f81d2c47d63131c9c5bc6ab9bcc36b68632d7296::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 6, b"HACHIKO", b"Hachiko", b"The Hachiko Token is a new digital asset inspired by the beloved story of Hachiko, the loyal Akita dog known for his remarkable faithfulness. This cryptocurrency aims to capture the spirit of Hachiko's devotion and loyalty, drawing parallels between the dogs legendary commitment and the community-driven nature of the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725701098923_e4e5a9d1041dca2f06e780dd07a8d1a0_485ea272bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

