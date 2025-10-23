module 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin {
    struct CanvasAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CanvasRules has copy, drop, store {
        base_paint_fee: u64,
        pixel_price_multiplier_reset_ms: u64,
        canvas_treasury: address,
        paint_coin_fee: u64,
    }

    public fun base_paint_fee(arg0: &CanvasRules) : u64 {
        arg0.base_paint_fee
    }

    public fun canvas_treasury(arg0: &CanvasRules) : address {
        arg0.canvas_treasury
    }

    public fun claim_fees<T0>(arg0: &mut CanvasAdminCap, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)
    }

    public fun id(arg0: &CanvasAdminCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CanvasAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CanvasAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun new_rules(arg0: u64, arg1: u64, arg2: address, arg3: u64) : CanvasRules {
        CanvasRules{
            base_paint_fee                  : arg0,
            pixel_price_multiplier_reset_ms : arg1,
            canvas_treasury                 : arg2,
            paint_coin_fee                  : arg3,
        }
    }

    public fun paint_coin_fee(arg0: &CanvasRules) : u64 {
        arg0.paint_coin_fee
    }

    public fun pixel_price_multiplier_reset_ms(arg0: &CanvasRules) : u64 {
        arg0.pixel_price_multiplier_reset_ms
    }

    public(friend) fun update_base_paint_fee(arg0: &mut CanvasRules, arg1: u64) {
        arg0.base_paint_fee = arg1;
    }

    public(friend) fun update_canvas_treasury(arg0: &mut CanvasRules, arg1: address) {
        arg0.canvas_treasury = arg1;
    }

    public(friend) fun update_pixel_price_multiplier_reset_ms(arg0: &mut CanvasRules, arg1: u64) {
        arg0.pixel_price_multiplier_reset_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

