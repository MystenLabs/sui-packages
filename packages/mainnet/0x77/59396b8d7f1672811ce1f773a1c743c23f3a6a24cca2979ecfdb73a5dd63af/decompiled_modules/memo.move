module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::memo {
    public(friend) fun borrow_rate_updated() : 0x1::string::String {
        0x1::string::utf8(b"borrow rate updated")
    }

    public(friend) fun collateral_modified(arg0: bool) : 0x1::string::String {
        if (arg0) {
            0x1::string::utf8(b"collateral deposited")
        } else {
            0x1::string::utf8(b"collateral withdrawn")
        }
    }

    public(friend) fun funding_rate_updated() : 0x1::string::String {
        0x1::string::utf8(b"funding rate updated")
    }

    public(friend) fun market_config_updated() : 0x1::string::String {
        0x1::string::utf8(b"market config updated")
    }

    public(friend) fun order_cancelled_by_user() : 0x1::string::String {
        0x1::string::utf8(b"user cancelled order")
    }

    public(friend) fun order_cancelled_from_code(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            order_cancelled_position_liquidated()
        } else {
            order_cancelled_position_closed()
        }
    }

    public(friend) fun order_cancelled_invalid_match() : 0x1::string::String {
        0x1::string::utf8(b"invalid match")
    }

    public(friend) fun order_cancelled_missing_linked_position() : 0x1::string::String {
        0x1::string::utf8(b"linked position not found")
    }

    public(friend) fun order_cancelled_position_closed() : 0x1::string::String {
        0x1::string::utf8(b"position closed")
    }

    public(friend) fun order_cancelled_position_liquidated() : 0x1::string::String {
        0x1::string::utf8(b"position liquidated")
    }

    public(friend) fun order_cancelled_slippage_exceeded() : 0x1::string::String {
        0x1::string::utf8(b"slippage exceeded")
    }

    public(friend) fun order_cancelled_too_many_failed_matches() : 0x1::string::String {
        0x1::string::utf8(b"fail too many times")
    }

    public(friend) fun order_created() : 0x1::string::String {
        0x1::string::utf8(b"order created")
    }

    public(friend) fun order_filled() : 0x1::string::String {
        0x1::string::utf8(b"order filled")
    }

    public(friend) fun order_updated() : 0x1::string::String {
        0x1::string::utf8(b"order updated")
    }

    public(friend) fun position_closed() : 0x1::string::String {
        0x1::string::utf8(b"position closed")
    }

    public(friend) fun position_closed_code() : u8 {
        0
    }

    public(friend) fun position_linked_order_modified(arg0: bool) : 0x1::string::String {
        if (arg0) {
            0x1::string::utf8(b"linked order added")
        } else {
            0x1::string::utf8(b"linked order removed")
        }
    }

    public(friend) fun position_liquidated() : 0x1::string::String {
        0x1::string::utf8(b"position liquidated")
    }

    public(friend) fun position_liquidated_code() : u8 {
        1
    }

    public(friend) fun position_modified(arg0: bool) : 0x1::string::String {
        if (arg0) {
            0x1::string::utf8(b"position increased")
        } else {
            0x1::string::utf8(b"position decreased")
        }
    }

    public(friend) fun position_opened() : 0x1::string::String {
        0x1::string::utf8(b"position opened")
    }

    public(friend) fun pre_order_cancelled() : 0x1::string::String {
        0x1::string::utf8(b"pre-order cancelled")
    }

    public(friend) fun pre_order_created() : 0x1::string::String {
        0x1::string::utf8(b"pre-order created")
    }

    public(friend) fun protocol_fee_collected() : 0x1::string::String {
        0x1::string::utf8(b"protocol fee collected")
    }

    public(friend) fun token_pool_info_updated() : 0x1::string::String {
        0x1::string::utf8(b"token pool info updated")
    }

    public(friend) fun wlp_equity_fee() : 0x1::string::String {
        0x1::string::utf8(b"fee")
    }

    public(friend) fun wlp_equity_leftover() : 0x1::string::String {
        0x1::string::utf8(b"leftover")
    }

    public(friend) fun wlp_equity_loss() : 0x1::string::String {
        0x1::string::utf8(b"loss")
    }

    public(friend) fun wlp_equity_win() : 0x1::string::String {
        0x1::string::utf8(b"win")
    }

    public(friend) fun wlp_minted() : 0x1::string::String {
        0x1::string::utf8(b"wlp minted")
    }

    public(friend) fun wlp_redeem_cancelled() : 0x1::string::String {
        0x1::string::utf8(b"wlp redeem cancelled")
    }

    public(friend) fun wlp_redeem_rejected() : 0x1::string::String {
        0x1::string::utf8(b"wlp redeem rejected")
    }

    public(friend) fun wlp_redeem_requested() : 0x1::string::String {
        0x1::string::utf8(b"wlp redeem requested")
    }

    public(friend) fun wlp_redeem_settled() : 0x1::string::String {
        0x1::string::utf8(b"wlp redeem settled")
    }

    // decompiled from Move bytecode v7
}

