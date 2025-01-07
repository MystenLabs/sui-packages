module 0x5f50e8eb8957a8377eb9961d51aad85e3d1f722f32ff0665a26f087a05736ab3::mun3 {
    struct MUN3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN3>(arg0, 9, b"MUN3", b"MUn 03", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/bd1771273db78fcb1c4fd7c6c9a62bcbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUN3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

