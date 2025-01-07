module 0x5954cb1f80976eaea1a5ce67aa3ec70dcb27c42060192f5ba237990427596186::bluedolf {
    struct BLUEDOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOLF>(arg0, 6, b"BLUEDOLF", b"BLUEDOLF The Blue Nose Reindeer Coin", b"At BLUEDOLF, we celebrate the spirit of the holiday season through cryptocurrency trading. Join our unique meme coin community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_Bprq_QPA_7a_Pak_Nq2q7_U_Ff6e_1_faaf820ff4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

