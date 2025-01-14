module 0xa78bb7a44bf2f532450693a5a22f9be7bca834ad6a490374d112f0b0021d47a1::sheesh {
    struct SHEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEESH>(arg0, 6, b"SHEESH", b"SHEEESH", x"544845204f4e4c59204f4646494349414c20534845455348204f4e20535549204e4554574f524b210a0a53686565736821204368696c6c206f75742062726f2e205965612c20796f7527766520666f756e6420612067656d2e205965612c20796f75276c6c206861766520656e6f756768206d6f6e657920666f722074686174206c616d626f20796f7520616c7761797320647265616d74206f662e205965732c207965732c20796f752063616e206665656420796f75722076696c6c6167652e205368656573682e204a757374206a6f696e20757320616c72656164792e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_18_17_19_7da466bcd7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

