module 0x18696dc281c0817ccc1918f7ab92291b084c11bbad104efb3b56872d025cc5f8::wct {
    struct WCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCT>(arg0, 6, b"WCT", b"WalletConnect", x"57616c6c6574436f6e6e656374204e6574776f726b20c491616e67207068c3a17420747269e1bb836e207468c3a06e68206de1bb99742068e1bb872073696e68207468c3a169206b68c3b46e672063e1baa76e2063e1baa57020717579e1bb816e20c491c6b0e1bba3632068e1bb97207472e1bba32062e1bb9f692057616c6c6574436f6e6e65637420546f6b656e2028574354292076c3a02063e1bb996e6720c491e1bb936e6720333520747269e1bb8775206e67c6b0e1bb9d692064c3b96e672e20c490c6b0e1bba3632068e1bb97207472e1bba32062e1bb9f692063c3a163206e68c3a020c49169e1bb81752068c3a06e68206e6f6465206ce1bb9b6e20746fc3a06e2063e1baa775206e68c6b020436f6e73656e7379732c2052656f776e2c204c65646765722c204b696c6e2c204669676d656e742c204576", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/b208a114-8cdd-489f-8eec-78d47a222c1b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

