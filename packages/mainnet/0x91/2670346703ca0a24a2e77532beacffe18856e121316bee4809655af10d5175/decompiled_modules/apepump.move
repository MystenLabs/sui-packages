module 0x912670346703ca0a24a2e77532beacffe18856e121316bee4809655af10d5175::apepump {
    struct APEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEPUMP>(arg0, 6, b"APEPUMP", b"APE PUMP", b"https://x.com/Ape_Pump_ : https://discord.gg/apepump : https://t.me/TheRealApePump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/356345_77ccae648e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

