module 0x3462c249dc986200f97907259324d445696db6641fb268544d61a833705804f0::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS>(arg0, 9, b"AS", b"Cat ", b"Nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/384c3f7e-86f3-49d6-938b-1ea4dbe3c980.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AS>>(v1);
    }

    // decompiled from Move bytecode v6
}

