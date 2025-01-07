module 0x93372633fb275872a895f53bc064578673f18fe1a1188182f65d7b8f572d5ee5::orbiter_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    public entry fun xbridge_orbiter<T0>(arg0: 0x1::string::String, arg1: u32, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 1) {
            0x1::string::utf8(b"9001")
        } else if (arg1 == 42161) {
            0x1::string::utf8(b"9002")
        } else if (arg1 == 137) {
            0x1::string::utf8(b"9006")
        } else if (arg1 == 10) {
            0x1::string::utf8(b"9007")
        } else if (arg1 == 1088) {
            0x1::string::utf8(b"9010")
        } else if (arg1 == 56) {
            0x1::string::utf8(b"9015")
        } else if (arg1 == 1101) {
            0x1::string::utf8(b"9017")
        } else if (arg1 == 534352) {
            0x1::string::utf8(b"9019")
        } else if (arg1 == 8453) {
            0x1::string::utf8(b"9021")
        } else if (arg1 == 59144) {
            0x1::string::utf8(b"9023")
        } else if (arg1 == 5000) {
            0x1::string::utf8(b"9024")
        } else if (arg1 == 196) {
            0x1::string::utf8(b"9027")
        } else if (arg1 == 169) {
            0x1::string::utf8(b"9031")
        } else if (arg1 == 81457) {
            0x1::string::utf8(b"9040")
        } else {
            assert!(arg1 == 34443, 1);
            0x1::string::utf8(b"9047")
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, arg5);
        let v1 = 0x1::string::utf8(b"c=");
        0x1::string::append(&mut v1, v0);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"&t="));
        0x1::string::append(&mut v1, arg3);
        0x7f058e6f93bfbd5166ff6b36aa81532ed3bc616e157719d0bfcde4ac83b648d3::OrbiterRouter::memo(v1);
        let v2 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg7),
            _to        : arg3,
            _token     : arg4,
            _amount    : 0x2::coin::value<T0>(&arg6),
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v2);
    }

    // decompiled from Move bytecode v6
}

