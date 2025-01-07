module 0x739ca36b7cc65cd25a2ed61608e0088e48f25e2cccd6e2e723ebe7e3b523a5ef::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"JOE", b"Joe Assistant AI", x"4a6f6520417373697374616e7420414920284a4f452920706f77657273204a6f652c206120637573746f6d20414920617373697374616e7420666f7220656e7465727072697365732c20656e61626c696e6720736563757265207472616e73616374696f6e732c207072656d69756d2041492066656174757265732c20616e64207573657220726577617264732e204d616465206279206f7572204b6f644b6f644b6f642073747564696fe280997320736f6c696420696e7465726e6174696f6e616c207465616d206f6620343020646576656c6f706572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735165698953.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

