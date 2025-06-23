module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info {
    struct MonsterInfo has copy, drop, store {
        name: 0x1::ascii::String,
        asset_frame: u256,
        current_hp: u256,
        max_hp: u256,
        attack_ids: vector<u64>,
        base_attack: u256,
        current_attack: u256,
        current_level: u256,
        base_exp: u256,
        current_exp: u256,
    }

    public fun get(arg0: &MonsterInfo) : (0x1::ascii::String, u256, u256, u256, vector<u64>, u256, u256, u256, u256, u256) {
        (arg0.name, arg0.asset_frame, arg0.current_hp, arg0.max_hp, arg0.attack_ids, arg0.base_attack, arg0.current_attack, arg0.current_level, arg0.base_exp, arg0.current_exp)
    }

    public fun get_asset_frame(arg0: &MonsterInfo) : u256 {
        arg0.asset_frame
    }

    public fun get_attack_ids(arg0: &MonsterInfo) : vector<u64> {
        arg0.attack_ids
    }

    public fun get_base_attack(arg0: &MonsterInfo) : u256 {
        arg0.base_attack
    }

    public fun get_base_exp(arg0: &MonsterInfo) : u256 {
        arg0.base_exp
    }

    public fun get_current_attack(arg0: &MonsterInfo) : u256 {
        arg0.current_attack
    }

    public fun get_current_exp(arg0: &MonsterInfo) : u256 {
        arg0.current_exp
    }

    public fun get_current_hp(arg0: &MonsterInfo) : u256 {
        arg0.current_hp
    }

    public fun get_current_level(arg0: &MonsterInfo) : u256 {
        arg0.current_level
    }

    public fun get_max_hp(arg0: &MonsterInfo) : u256 {
        arg0.max_hp
    }

    public fun get_name(arg0: &MonsterInfo) : 0x1::ascii::String {
        arg0.name
    }

    public fun new(arg0: 0x1::ascii::String, arg1: u256, arg2: u256, arg3: u256, arg4: vector<u64>, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256) : MonsterInfo {
        MonsterInfo{
            name           : arg0,
            asset_frame    : arg1,
            current_hp     : arg2,
            max_hp         : arg3,
            attack_ids     : arg4,
            base_attack    : arg5,
            current_attack : arg6,
            current_level  : arg7,
            base_exp       : arg8,
            current_exp    : arg9,
        }
    }

    public(friend) fun set(arg0: &mut MonsterInfo, arg1: 0x1::ascii::String, arg2: u256, arg3: u256, arg4: u256, arg5: vector<u64>, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) {
        arg0.name = arg1;
        arg0.asset_frame = arg2;
        arg0.current_hp = arg3;
        arg0.max_hp = arg4;
        arg0.attack_ids = arg5;
        arg0.base_attack = arg6;
        arg0.current_attack = arg7;
        arg0.current_level = arg8;
        arg0.base_exp = arg9;
        arg0.current_exp = arg10;
    }

    public(friend) fun set_asset_frame(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.asset_frame = arg1;
    }

    public(friend) fun set_attack_ids(arg0: &mut MonsterInfo, arg1: vector<u64>) {
        arg0.attack_ids = arg1;
    }

    public(friend) fun set_base_attack(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.base_attack = arg1;
    }

    public(friend) fun set_base_exp(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.base_exp = arg1;
    }

    public(friend) fun set_current_attack(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.current_attack = arg1;
    }

    public(friend) fun set_current_exp(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.current_exp = arg1;
    }

    public(friend) fun set_current_hp(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.current_hp = arg1;
    }

    public(friend) fun set_current_level(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.current_level = arg1;
    }

    public(friend) fun set_max_hp(arg0: &mut MonsterInfo, arg1: u256) {
        arg0.max_hp = arg1;
    }

    public(friend) fun set_name(arg0: &mut MonsterInfo, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

