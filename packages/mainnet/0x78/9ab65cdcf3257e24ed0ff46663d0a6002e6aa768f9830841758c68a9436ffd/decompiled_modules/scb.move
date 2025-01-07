module 0x789ab65cdcf3257e24ed0ff46663d0a6002e6aa768f9830841758c68a9436ffd::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"Sui Copytrading Bot", x"57656c636f6d6520746f2053756920436f707974726164696e6720426f742c2074686520756c74696d617465205375692074726164696e6720626f74206f6e2054656c656772616d2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Create_a_logo_for_Sui_Copytrading_Bot_a_moder_0_7a88479e50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

