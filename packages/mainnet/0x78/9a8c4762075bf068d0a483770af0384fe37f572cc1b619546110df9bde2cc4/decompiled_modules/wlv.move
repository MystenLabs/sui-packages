module 0x789a8c4762075bf068d0a483770af0384fe37f572cc1b619546110df9bde2cc4::wlv {
    struct WLV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLV>(arg0, 9, b"WLV", b"WOLVERINE", b"This token is built to be unstoppable and undeniable just like it's nameshake.With an unstoppable supply,ferecious community,and a claws-out approach to decentralised finance,WLV is here to claw it's way to the top of the meme coin game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/240244f8-7ba2-4359-8655-74e2234ad66d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLV>>(v1);
    }

    // decompiled from Move bytecode v6
}

