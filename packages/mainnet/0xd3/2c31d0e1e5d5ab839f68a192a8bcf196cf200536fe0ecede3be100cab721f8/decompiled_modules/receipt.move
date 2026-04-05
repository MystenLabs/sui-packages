module 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt {
    struct RECEIPT has drop {
        dummy_field: bool,
    }

    struct AqReceipt has key {
        id: 0x2::object::UID,
        receipt_amount: u64,
        amount_human: 0x1::string::String,
        deposit_epoch: u64,
        locked_until_epoch: u64,
    }

    struct ReceiptTreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun augment_receipt(arg0: &ReceiptTreasuryCap, arg1: &mut AqReceipt, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.receipt_amount;
        let v1 = v0 + arg2;
        let v2 = ((((v0 as u128) * (arg1.deposit_epoch as u128) + (arg2 as u128) * (0x2::tx_context::epoch(arg3) as u128) + (v1 as u128) - 1) / (v1 as u128)) as u64);
        if (v2 > arg1.deposit_epoch) {
            arg1.deposit_epoch = v2;
        };
        arg1.receipt_amount = v1;
        arg1.amount_human = format_amount_2dp(v1);
    }

    public fun deplete_receipt(arg0: &ReceiptTreasuryCap, arg1: &mut AqReceipt, arg2: u64) {
        assert!(arg1.receipt_amount >= arg2, 1);
        arg1.receipt_amount = arg1.receipt_amount - arg2;
        arg1.amount_human = format_amount_2dp(arg1.receipt_amount);
    }

    public fun deposit_epoch(arg0: &AqReceipt) : u64 {
        arg0.deposit_epoch
    }

    public fun destroy_empty_receipt(arg0: AqReceipt) {
        assert!(arg0.receipt_amount == 0, 2);
        let AqReceipt {
            id                 : v0,
            receipt_amount     : _,
            amount_human       : _,
            deposit_epoch      : _,
            locked_until_epoch : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun format_amount_2dp(arg0: u64) : 0x1::string::String {
        let v0 = arg0 % 1000000 / 10000;
        let v1 = u64_to_string(arg0 / 1000000);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        if (v0 < 10) {
            0x1::string::append(&mut v1, 0x1::string::utf8(b"0"));
        };
        0x1::string::append(&mut v1, u64_to_string(v0));
        v1
    }

    fun init(arg0: RECEIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RECEIPT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AquaYield Deposit Receipt"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Non-transferable deposit receipt representing {amount_human} USDC in the AquaYield Vault. Auto-compounding, optimized multi-stablecoin yield, always redeemable."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 800'><defs><radialGradient id='topRightRad' cx='100%25' cy='0%25' r='70%25' fx='100%25' fy='0%25'><stop offset='0%25' stop-color='%231a2a44'/><stop offset='70%25' stop-color='%230b0c10' stop-opacity='0'/></radialGradient><radialGradient id='bottomLeftRad' cx='0%25' cy='100%25' r='80%25' fx='0%25' fy='100%25'><stop offset='0%25' stop-color='%230e1b2f'/><stop offset='80%25' stop-color='%230b0c10' stop-opacity='0'/></radialGradient><filter id='suiGlow' x='-50%25' y='-50%25' width='200%25' height='200%25'><feDropShadow dx='0' dy='0' stdDeviation='15' flood-color='%234da2ff' flood-opacity='0.8'/><feDropShadow dx='0' dy='0' stdDeviation='30' flood-color='%234da2ff' flood-opacity='0.4'/></filter><linearGradient id='logoGrad' x1='0%25' y1='0%25' x2='100%25' y2='100%25'><stop offset='0%25' stop-color='%234da2ff' stop-opacity='0.15'/><stop offset='100%25' stop-color='%234da2ff' stop-opacity='0.0'/></linearGradient></defs><rect width='800' height='800' fill='%230b0c10'/><rect width='800' height='800' fill='url(%23bottomLeftRad)'/><rect width='800' height='800' fill='url(%23topRightRad)'/><g transform='translate(650, 40) scale(1.6)'><path d='M57 24.6C54 17.4 44.8 8.7 44.8 8.7s3 7.4.8 17.3l3.5-3s3.3 1.4 3.7 5c.5 4.4-2 10.6-2 10.6s-5.5-1.7-13.9-1.6l-3-19.6l7.2 4.7L32 2l-9 19.9l7.2-4.7l-3 19.6c-8.4-.1-13.9 1.6-13.9 1.6s-2.5-6.2-2-10.6c.4-3.5 3.7-5 3.7-5l3.5 3c-2.2-9.8.8-17.3.8-17.3S10 17.4 7 24.6C3.9 32 2 40.8 2 40.8l6.4 5.9s5.6-1.7 10-2c4.1-.3 8.9-.4 8.9-.4l-.6 8.7l5.3 9l5.3-9l-.6-8.7s4.8.1 8.9.4c4.3.3 10 2 10 2l6.4-5.9s-1.9-8.8-5-16.2' fill='%234da2ff'/></g><g transform='translate(16, 16) scale(12)' opacity='0.4'><path d='M57 24.6C54 17.4 44.8 8.7 44.8 8.7s3 7.4.8 17.3l3.5-3s3.3 1.4 3.7 5c.5 4.4-2 10.6-2 10.6s-5.5-1.7-13.9-1.6l-3-19.6l7.2 4.7L32 2l-9 19.9l7.2-4.7l-3 19.6c-8.4-.1-13.9 1.6-13.9 1.6s-2.5-6.2-2-10.6c.4-3.5 3.7-5 3.7-5l3.5 3c-2.2-9.8.8-17.3.8-17.3S10 17.4 7 24.6C3.9 32 2 40.8 2 40.8l6.4 5.9s5.6-1.7 10-2c4.1-.3 8.9-.4 8.9-.4l-.6 8.7l5.3 9l5.3-9l-.6-8.7s4.8.1 8.9.4c4.3.3 10 2 10 2l6.4-5.9s-1.9-8.8-5-16.2' fill='url(%23logoGrad)'/></g><text x='60' y='100' font-family='&apos;Inter&apos;, system-ui, -apple-system, sans-serif' font-size='55' font-weight='800' fill='%23ffffff' letter-spacing='-1'>AquaYield</text><text x='60' y='148' font-family='&apos;Inter&apos;, system-ui, -apple-system, sans-serif' font-size='26' font-weight='600' fill='%234da2ff' letter-spacing='4.2'>DEPOSIT RECEIPT</text><text x='400' y='450' font-family='system-ui, -apple-system, sans-serif' font-size='200' font-weight='900' fill='%23ffffff' text-anchor='middle' filter='url(%23suiGlow)' letter-spacing='-4'>{amount_human}</text><text x='400' y='550' font-family='system-ui, -apple-system, sans-serif' font-size='50' font-weight='800' fill='%238b92a5' text-anchor='middle' letter-spacing='8'>USDC DEPOSITED</text><line x1='60' y1='700' x2='740' y2='700' stroke='%231f3c64' stroke-width='2'/><text x='60' y='740' font-family='monospace' font-size='18' fill='%234da2ff' font-weight='bold' opacity='0.8'>ON-CHAIN SOULBOUND NFT</text><text x='740' y='740' font-family='monospace' font-size='18' fill='%238b92a5' font-weight='bold' text-anchor='end' opacity='0.8'>100% SUI NATIVE</text></svg>"));
        let v5 = 0x2::display::new_with_fields<AqReceipt>(&v0, v1, v3, arg1);
        0x2::display::update_version<AqReceipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AqReceipt>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ReceiptTreasuryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ReceiptTreasuryCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun join_receipts(arg0: &mut AqReceipt, arg1: AqReceipt, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(v0 > arg0.locked_until_epoch, 5);
        assert!(v0 > arg1.locked_until_epoch, 5);
        arg0.receipt_amount = arg0.receipt_amount + arg1.receipt_amount;
        arg0.amount_human = format_amount_2dp(arg0.receipt_amount);
        if (arg1.deposit_epoch > arg0.deposit_epoch) {
            arg0.deposit_epoch = arg1.deposit_epoch;
        };
        if (arg1.locked_until_epoch > arg0.locked_until_epoch) {
            arg0.locked_until_epoch = arg1.locked_until_epoch;
        };
        let AqReceipt {
            id                 : v1,
            receipt_amount     : _,
            amount_human       : _,
            deposit_epoch      : _,
            locked_until_epoch : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun lock_receipt(arg0: &mut AqReceipt, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 0x2::tx_context::epoch(arg2) + 30, 4);
        if (arg1 > arg0.locked_until_epoch) {
            arg0.locked_until_epoch = arg1;
        };
    }

    public fun locked_until_epoch(arg0: &AqReceipt) : u64 {
        arg0.locked_until_epoch
    }

    public fun mint_receipt(arg0: &ReceiptTreasuryCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AqReceipt {
        AqReceipt{
            id                 : 0x2::object::new(arg2),
            receipt_amount     : arg1,
            amount_human       : format_amount_2dp(arg1),
            deposit_epoch      : 0x2::tx_context::epoch(arg2),
            locked_until_epoch : 0,
        }
    }

    public fun receipt_amount(arg0: &AqReceipt) : u64 {
        arg0.receipt_amount
    }

    public fun split_receipt(arg0: &mut AqReceipt, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AqReceipt {
        assert!(0x2::tx_context::epoch(arg2) > arg0.locked_until_epoch, 5);
        assert!(arg0.receipt_amount >= arg1, 3);
        arg0.receipt_amount = arg0.receipt_amount - arg1;
        arg0.amount_human = format_amount_2dp(arg0.receipt_amount);
        AqReceipt{
            id                 : 0x2::object::new(arg2),
            receipt_amount     : arg1,
            amount_human       : format_amount_2dp(arg1),
            deposit_epoch      : arg0.deposit_epoch,
            locked_until_epoch : arg0.locked_until_epoch,
        }
    }

    public fun transfer_receipt(arg0: AqReceipt, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg2) > arg0.locked_until_epoch, 5);
        0x2::transfer::transfer<AqReceipt>(arg0, arg1);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

