module 0xc51eba7180ca59651562d962510238b6e28867a22bcf6be8faf5017f09287bb::pizzaguy {
    struct PIZZAGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZAGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZAGUY>(arg0, 6, b"PIZZAGUY", b"Justice For Pizza Guy", x"57652068617665206e6f77206465636964656420746f2074616b652074686973206f76657220617320612043544f2c207468652064657620776173206120626164206163746f7220616e642064756d706564207468652063686172740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4k_NS_9_E_Dwpi_JNB_Jp_UCQ_2e_Yc_Zkuj5_Xo4cco4jsrwk9pump_20fe24bf71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZAGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZAGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

