module 0x69b87e8de42ceb31822f192fd94a91c66cd27ebfe56736f9efa022047ec126a4::dwg {
    struct DWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWG>(arg0, 6, b"Dwg", b"Dog wif glasses", x"446f67207769746820676c61737365730a0a416c6c20547769747465722c2054656c656772616d2c20616e64206f7468657220636f6d6d756e6974696573207573650a656e7468757369617374732077686f206c6f7665207468697320636f696e2e0a0a49742077617320612062656175746966756c20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_playful_anthropomorphized_dog_wearing_a_sty_0_cbc72cfac2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

