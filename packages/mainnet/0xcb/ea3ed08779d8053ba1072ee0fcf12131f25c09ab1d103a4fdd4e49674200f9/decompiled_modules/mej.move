module 0xcbea3ed08779d8053ba1072ee0fcf12131f25c09ab1d103a4fdd4e49674200f9::mej {
    struct MEJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEJ>(arg0, 9, b"MEJ", b"Memejeem", b"Meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62f99ffa-0562-42c7-a84e-933af5141742.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

