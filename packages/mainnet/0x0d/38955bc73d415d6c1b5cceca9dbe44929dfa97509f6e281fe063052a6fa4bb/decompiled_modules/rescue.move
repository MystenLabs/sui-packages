module 0xd38955bc73d415d6c1b5cceca9dbe44929dfa97509f6e281fe063052a6fa4bb::rescue {
    struct RESCUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESCUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESCUE>(arg0, 9, b"RESCUE", b"Rescue Token", x"496e6974696174697665733a200a2d20537570706f727420466c6f72696461204669726520616e64204f6365616e205265736375650a2d20517561727465726c7920426f6e7573204169722044726f707320746f20766572696669656420464c20454d5473200a2d20322520464545205355492f524553435545204c697175696469747920506f6f6c206f6e204365747573200a2d204f6e20426f61726420466972737420526573706f6e6465727320746f20535549204e6574776f726b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/850a709fa00d529326afbe495a3cda8fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESCUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESCUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

