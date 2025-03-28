module 0x6dc6dfd8934d7ae2084cbad43210be4c1df3c39ffdb8df79c87c00647846a347::dne {
    struct DNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNE>(arg0, 9, b"DNE", b"denho", b"im new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7f0667df19af032353a244734a4423fablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

