module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::storage {
    public fun get_ball_x_positions() : vector<vector<u8>> {
        vector[b"125", b"195", b"265", b"335", b"405", b"475"]
    }

    public fun get_circle_prefix() : vector<u8> {
        b"%3Ccircle%20cx='"
    }

    public fun get_circle_suffix() : vector<u8> {
        b"'%20cy='370'%20r='25'%20fill='%232b2b2b'/%3E"
    }

    public fun get_svg_prefix() : vector<u8> {
        b"data:image/svg+xml;utf8,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20800%20520'%3E%3Cdefs%3E%3Cfilter%20id='shadow'%20x='-10%25'%20y='-10%25'%20width='120%25'%20height='120%25'%3E%3CfeDropShadow%20dx='0'%20dy='10'%20stdDeviation='12'%20flood-opacity='0.4'%20flood-color='%23000'/%3E%3C/filter%3E%3CradialGradient%20id='bg'%20cx='50%25'%20cy='50%25'%20r='75%25'%20fx='50%25'%20fy='50%25'%3E%3Cstop%20offset='0%25'%20stop-color='%232d2d2d'/%3E%3Cstop%20offset='100%25'%20stop-color='%230a0a0a'/%3E%3C/radialGradient%3E%3C/defs%3E%3Crect%20width='100%25'%20height='100%25'%20fill='url(%23bg)'/%3E%3Cpath%20d='M%2060%2060%20L%20530%2060%20L%20740%2060%20L%20725%2080%20L%20740%20100%20L%20725%20120%20L%20740%20140%20L%20725%20160%20L%20740%20180%20L%20725%20200%20L%20740%20220%20L%20725%20240%20L%20740%20260%20L%20725%20280%20L%20740%20300%20L%20725%20320%20L%20740%20340%20L%20725%20360%20L%20740%20380%20L%20725%20400%20L%20740%20420%20L%20725%20440%20L%20740%20460%20L%20580%20460%20L%2060%20460%20L%2075%20440%20L%2060%20420%20L%2075%20400%20L%2060%20380%20L%2075%20360%20L%2060%20340%20L%2075%20320%20L%2060%20300%20L%2075%20280%20L%2060%20260%20L%2075%20240%20L%2060%20220%20L%2075%20200%20L%2060%20180%20L%2075%20160%20L%2060%20140%20L%2075%20120%20L%2060%20100%20L%2075%2080%20Z'%20fill='%23fcfbf7'%20filter='url(%23shadow)'/%3E%3Ccircle%20cx='555'%20cy='55'%20r='25'%20fill='%23181818'/%3E%3Ccircle%20cx='555'%20cy='465'%20r='25'%20fill='%23141414'/%3E%3Cline%20x1='555'%20y1='88'%20x2='555'%20y2='432'%20stroke='%23333'%20stroke-width='1.5'%20stroke-dasharray='6,5'%20opacity='0.7'/%3E%3Cg%20transform='translate(307,300)'%20opacity='0.6'%3E%3Ctext%20x='0'%20y='0'%20font-family='Arial%20Black,Impact,sans-serif'%20font-size='180'%20font-weight='900'%20fill='none'%20stroke='%23e6e6e6'%20stroke-width='4'%20text-anchor='middle'%3Etebc%3C/text%3E%3Ctext%20x='0'%20y='0'%20font-family='Arial%20Black,Impact,sans-serif'%20font-size='180'%20font-weight='900'%20fill='none'%20stroke='%23ececec'%20stroke-width='2'%20text-anchor='middle'%20transform='scale(0.96)'%3Etebc%3C/text%3E%3Ctext%20x='0'%20y='0'%20font-family='Arial%20Black,Impact,sans-serif'%20font-size='180'%20font-weight='900'%20fill='none'%20stroke='%23f2f2f2'%20stroke-width='1.2'%20text-anchor='middle'%20transform='scale(0.92)'%3Etebc%3C/text%3E%3C/g%3E%3Cg%20fill='%231a1a1a'%20font-family='Arial,Helvetica,sans-serif'%3E%3Ctext%20x='100'%20y='135'%20font-size='17'%20font-weight='500'%20letter-spacing='0.5'%3ETHE%20EMPTY%20BOX%20CLUB%3C/text%3E%3Ctext%20x='100'%20y='205'%20font-family='Impact,Arial%20Black,sans-serif'%20font-size='78'%20textLength='410'%20lengthAdjust='spacingAndGlyphs'%20letter-spacing='1.5'%20font-weight='700'%3ECOSMO%20TICKET%3C/text%3E%3Ctext%20x='100'%20y='260'%20font-size='22'%20font-weight='500'%3EON-CHAIN%20DYNAMIC%3C/text%3E%3Ctext%20x='100'%20y='290'%20font-size='22'%20font-weight='500'%3ECOSMO%3C/text%3E"
    }

    public fun get_svg_suffix_post_campaign() : vector<u8> {
        b"%3C/text%3E%3Ctext%20x='-260'%20y='635'%3EPublished%20by%20TEBC%3C/text%3E%3Ctext%20x='-260'%20y='695'%3ETransparency:%20*Verified%20on%20SuiScan%3C/text%3E%3C/g%3E%3C/svg%3E"
    }

    public fun get_svg_suffix_pre_campaign() : vector<u8> {
        b"%3Ctext%20x='100'%20y='440'%20font-size='18'%20font-weight='500'%20letter-spacing='0.2'%3ENETWORK%20/%20SUI%20MAINNET%3C/text%3E%3C/g%3E%3Cg%20transform='rotate(-90)'%20fill='%231a1a1a'%20font-family='Arial,Helvetica,sans-serif'%20font-size='16'%20text-anchor='middle'%3E%3Ctext%20x='-260'%20y='595'%3EExpiry%20date:%20Only%20for%20Campaign%20%23"
    }

    public fun get_text_close() : vector<u8> {
        b"%3C/text%3E"
    }

    public fun get_text_mid() : vector<u8> {
        b"'%20y='370'%20text-anchor='middle'%20dominant-baseline='central'%20font-size='18'%20font-weight='bold'%20fill='%23fff'%20font-family='Arial,sans-serif'%3E"
    }

    public fun get_text_prefix() : vector<u8> {
        b"%3Ctext%20x='"
    }

    public fun get_ticket_base_url(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(get_svg_prefix());
        let v1 = get_ball_x_positions();
        let v2 = 0;
        while (v2 < 6) {
            0x1::string::append_utf8(&mut v0, get_circle_prefix());
            0x1::string::append_utf8(&mut v0, *0x1::vector::borrow<vector<u8>>(&v1, v2));
            0x1::string::append_utf8(&mut v0, get_circle_suffix());
            v2 = v2 + 1;
        };
        0x1::string::append_utf8(&mut v0, get_svg_suffix_pre_campaign());
        0x1::string::append_utf8(&mut v0, u64_to_ascii(arg0));
        0x1::string::append_utf8(&mut v0, b"%20-%20Ticket%20%23");
        0x1::string::append_utf8(&mut v0, u64_to_ascii(arg1));
        0x1::string::append_utf8(&mut v0, get_svg_suffix_post_campaign());
        v0
    }

    public fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    // decompiled from Move bytecode v7
}

