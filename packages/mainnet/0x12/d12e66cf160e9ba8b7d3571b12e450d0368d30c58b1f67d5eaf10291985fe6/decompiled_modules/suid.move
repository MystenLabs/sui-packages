module 0x12d12e66cf160e9ba8b7d3571b12e450d0368d30c58b1f67d5eaf10291985fe6::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 638 || 0x2::tx_context::epoch(arg1) == 639, 1);
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SUIDeFAI", x"535549446546414920696e7465677261746573204465466920616e6420414920746f20666f726d20616e2041492d506f77657265642044414f2064726976656e2062792063726f776420696e74656c6c6967656e63652e0a4275696c74206f6e207468652053554920626c6f636b636861696e2c206974207265646566696e6573206465636973696f6e2d6d616b696e6720696e2044654669207573696e6720616476616e63656420414920616c676f726974686d732077697468696e206120646563656e7472616c697a6564206672616d65776f726b2e0a4c657665726167696e672053554973207363616c6162696c6974792c2073706565642c20616e64206c6f7720636f7374732c20535549446546414920696e74726f64756365732061206e6577207374616e6461726420666f7220446546692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreigwdycwh3t22cprcqbgudapfo4rlqvgsr64ml7q5m5lkmb77azywe.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUID>(&mut v2, 1000000000000000, @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v2, @0xdf36999b1478d187cf8623e953c8fcff403c808a743758cc800f4c153e899919);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUID>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<SUID>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUID>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<SUID>, arg1: &mut 0x2::coin::CoinMetadata<SUID>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<SUID>(arg0, arg1, arg2);
        0x2::coin::update_symbol<SUID>(arg0, arg1, arg3);
        0x2::coin::update_description<SUID>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<SUID>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

