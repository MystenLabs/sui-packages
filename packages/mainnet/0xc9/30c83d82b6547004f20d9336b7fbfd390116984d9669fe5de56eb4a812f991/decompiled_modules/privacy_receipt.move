module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_receipt {
    struct ReceiptCap has store, key {
        id: 0x2::object::UID,
    }

    struct PrivacyReceipt has store, key {
        id: 0x2::object::UID,
        recipient: address,
        ciphertext: vector<u8>,
        nonce: vector<u8>,
        announcement_id: u64,
        timestamp_ms: u64,
    }

    struct ReceiptIssued has copy, drop {
        receipt: address,
        recipient: address,
        announcement_id: u64,
        timestamp_ms: u64,
        ciphertext_len: u64,
        nonce_len: u64,
    }

    public fun announcement_id(arg0: &PrivacyReceipt) : u64 {
        arg0.announcement_id
    }

    public fun ciphertext(arg0: &PrivacyReceipt) : &vector<u8> {
        &arg0.ciphertext
    }

    entry fun discard(arg0: PrivacyReceipt) {
        let PrivacyReceipt {
            id              : v0,
            recipient       : _,
            ciphertext      : _,
            nonce           : _,
            announcement_id : _,
            timestamp_ms    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReceiptCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ReceiptCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) entry fun issue(arg0: &ReceiptCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 3);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 1);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 2);
        let v0 = PrivacyReceipt{
            id              : 0x2::object::new(arg6),
            recipient       : arg1,
            ciphertext      : arg2,
            nonce           : arg3,
            announcement_id : arg4,
            timestamp_ms    : arg5,
        };
        let v1 = ReceiptIssued{
            receipt         : 0x2::object::uid_to_address(&v0.id),
            recipient       : arg1,
            announcement_id : arg4,
            timestamp_ms    : arg5,
            ciphertext_len  : 0x1::vector::length<u8>(&v0.ciphertext),
            nonce_len       : 0x1::vector::length<u8>(&v0.nonce),
        };
        0x2::event::emit<ReceiptIssued>(v1);
        0x2::transfer::public_transfer<PrivacyReceipt>(v0, arg1);
    }

    public fun nonce(arg0: &PrivacyReceipt) : &vector<u8> {
        &arg0.nonce
    }

    public fun recipient(arg0: &PrivacyReceipt) : address {
        arg0.recipient
    }

    public fun timestamp_ms(arg0: &PrivacyReceipt) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v7
}

