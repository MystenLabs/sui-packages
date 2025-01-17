module 0xd03039e99a4bcffc32600bb188aac79ce7a0f5c8fa6c14d2bc52a1c64457fbb7::trum {
    struct TRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUM>(arg0, 9, b"TRUM", b"$Trum", x"5472756d206973206261636b20616e642068652773207374726f6e676572207468616e20657665722e200d0a5768656e2074686520776f726c64206e656564732061206865726f2c20796f752063616c6ce280a6205452554d210d0a5472756d20646f65736e277420666c792c207468652077696e64206d616b65732068696d20666c792e0d0a54686520245472756d206d656d65206973206e6f74206f6e6c792070617274206f6620696e7465726e65742063756c747572652c2062757420616c736f2061207265666c656374696f6e206f6620686f7720746865207075626c696320766965777320616e64207075626c696320666967757265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a21b524c-f280-4a7c-9619-73ed8c6d320a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

