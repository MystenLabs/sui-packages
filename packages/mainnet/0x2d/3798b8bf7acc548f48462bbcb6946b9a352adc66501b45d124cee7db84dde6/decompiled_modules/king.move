module 0x2d3798b8bf7acc548f48462bbcb6946b9a352adc66501b45d124cee7db84dde6::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 9, b"King", b"KingPin", b"The Boss is a comic book character created by Marvel Comics. His real name is Wilson Fisk. He graces the comic book frames of many separate characters such as Spider-Man, Daredevil, Punisher, etc. He was created by Stan Lee and John Romita, Sr.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5bdfb986745ed56273cf61aa668f9e47blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

