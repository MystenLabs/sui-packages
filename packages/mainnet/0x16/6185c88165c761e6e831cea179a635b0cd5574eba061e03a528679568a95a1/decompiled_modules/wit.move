module 0x166185c88165c761e6e831cea179a635b0cd5574eba061e03a528679568a95a1::wit {
    struct WIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIT>(arg0, 6, b"WIT", b"catwitsurfboard", x"5375726665724361744d6176206f6e2049472e0a526570726573656e74696e672074686520776174657220636861696e2c206361746368696e207468652062696720776176657320647572696e672043617420537a6e2e0a536f6c20686173205749462c205375692068617320574954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SURFINGCAT_cbd7867e38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

